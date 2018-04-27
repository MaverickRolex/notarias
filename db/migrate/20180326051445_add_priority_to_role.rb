class AddPriorityToRole < ActiveRecord::Migration[5.0]
  def change
    add_column :roles, :priority, :integer

    Role.create! name: 'Super Admin',  priority: Role::SUPER_ADMIN_ROLE
    Role.create! name: 'Admin',        priority: Role::ADMIN_ROLE
    Role.create! name: 'Common',       priority: Role::COMMON_ROLE
  end
end
