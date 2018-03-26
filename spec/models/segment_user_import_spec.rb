require 'rails_helper'

RSpec.describe SegmentUserImport, type: :model do

  describe "asociations" do
    it { is_expected.to belong_to(:segment) }
    it { is_expected.to belong_to(:uploader).with_foreign_key('uploader_id').class_name('User') }
  end

  describe "add a file" do
  	before(:each) do
      @segment = create(:segment)
      @uploader = create(:user)
      @seg_user_import = SegmentUserImport.create(segment: @segment, uploader: @uploader)
    end

    it "saves the file to 'file'" do
      @file =  File.open("/home/amed/Documentos/PV/PrepPV/spec/fixtures/excel_dummy.xls")
      expect { @seg_user_import.update(file: @file) }.to change { @seg_user_import.reload.file.url }
    end

    it "returns a error if isn't the file" do
      @file = File.open("/home/amed/Documentos/PV/PrepPV/spec/fixtures/excel_dummy.ods")
      @seg_user_import.update(file: @file)
      expect(@seg_user_import.errors).not_to be_empty
    end
  end
end
