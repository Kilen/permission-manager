class Account < ActiveRecord::Base
	has_one :user
	# 尽量别使用硬tab，这在不同编辑器下显示会很不友好
    has_many :account_roles
	has_many :roles, :through => :account_roles
    has_many :account_permissions
	has_many :permissions, :through => :account_permissions
	has_many :tasks
end
