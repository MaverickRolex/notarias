class UserImportManager
  attr_accessor :segment_user_import, :errors, :failed_user, :completed_users

  HEADERS = {
    "Correo" => "email",
    "Contraseña (opcional)" => "password",
    "Nombre" => "name",
    "Apellido Paterno" => "father_last_name",
    "Apellido Materno" => "mother_last_name"
  }

  def initialize(segment_user_import)
    @segment_user_import = segment_user_import
    @completed_users = []
  end

  def import!
    User.transaction do
      begin
        import
      rescue ActiveRecord::RecordInvalid => e
        @errors = @user.errors.full_messages
        @failed_user = @user
        raise ActiveRecord::Rollback
      rescue ActiveModel::UnknownAttributeError => e
        @errors = ["Hay un atributo desconocido en el archivo, detalles técnicos: #{e.message}"]
        @failed_user = @user
      rescue UnknownHeader, UnknowImportFileType => e
        @errors = [e.message]
      end
    end
  end

  # Import data from the file to database
  def import
    spreadsheet = open_spreadsheet
    header = spreadsheet.row(1).map { |header| HEADERS[header] }

    if header.any?(&:nil?)
      raise UnknownHeader.new "Hay encabezados desconocidos en el archivo, por favor use la plantilla"
    end
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      if row["password"].blank?
        row["password"] = generate_password(row)
        row["password_confirmation"] = row["password"]
      else
        row["password_confirmation"] = row["password"]
      end
      @user = User.new(row)
      @user.prevalidate_username_uniqueness = true # Sets username automatically
      @user.segments = [segment_user_import.segment]
      @user.pre_encrypted_password = row["password"]
      @user.save!
      @completed_users << @user
    end
    @segment_user_import.update(status: SegmentUserImport::COMPLETE)
  end

  # Open import file and detect extension file
  def open_spreadsheet
    case File.extname(segment_user_import.file.file.file)
      when ".csv" then ::Roo::CSV.new(segment_user_import.file.path, password: nil)
      when ".ods" then ::Roo::OpenOffice.new(segment_user_import.file.path, password: nil)
      when ".xls" then ::Roo::Excel.new(segment_user_import.file.path, password: nil)
      when ".xlsx" then ::Roo::Excelx.new(segment_user_import.file.path, password: nil)
    else raise UnknowImportFileType.new "Tipo de archivo desconocido: #{file.original_filename}"
    end
  end

  def generate_password(row)
    default_string(row["name"]) + default_string(row["father_last_name"]) + rand(2 ** 2).to_s
  end

  def default_string(value)
    value.blank? ? rand(2 ** 2).to_s : value
  end

  class UnknowImportFileType < Exception; end
  class UnknownHeader < Exception; end
end