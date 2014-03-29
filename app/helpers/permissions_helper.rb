module PermissionsHelper
  #这种工作建议用rails的国际化来做（I18N）
    def subject_name(subject)
        if subject == 'Task'
            return '任务'
        elsif subject == 'User'
            return '用户'
        elsif subject == 'Permission'
            return '权限'
        elsif subject == 'Role'
            return '角色'
        else
            return subject
        end
    end
end
