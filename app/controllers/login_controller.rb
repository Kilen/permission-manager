class LoginController < ApplicationController
    skip_before_filter :check_login

#ruby的一般缩进为两个空格
#尽量一个方法做一件事情，你这里干了两件事情，渲染登陆页面和处理登陆验证
    def index
        if request.method == 'GET'
            @account = Account.new
            render :index, layout: false
        else
            #方法后面是否有括号，这个需要统一一下
            #你这种密码验证相对比较简单，一般我们会加salt，甚至时间戳
            password = Digest::MD5.hexdigest(params[:password])
            search = Account.find_by_username params[:username]

            #建议用 ‘&&’ ‘||’
            # !search.nil? 其实可以直接用 search 就行了. 即：
            # if search && password == search.password
            if !search.nil? and password == search.password
                flash[:info] = '登录成功'
                session[:account] = search
                #标点符号后面一般会空一格
                redirect_to controller: 'tasks',action: 'index'
            else
                flash[:error] = '用户名不存在或密码不匹配！'
                redirect_to action: 'index'
            end
        end
    end

    def logout
        reset_session
        redirect_to action: 'index'
    end
end
