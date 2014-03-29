class RolesController < ApplicationController
  authorize_resource :role
  before_action :set_role, only: [:show, :edit, :update, :destroy]

  # GET /roles
  # GET /roles.json
  def index
    @roles = Role.all
  end

  # GET /roles/1
  # GET /roles/1.json
  def show
    @permissions = Permission.all
  end

  # GET /roles/new
  def new
    @role = Role.new
  end

  # GET /roles/1/edit
  def edit
  end

  # POST /roles
  # POST /roles.json
  # 一般情况下，我们只会用到一种返回格式，所以建议把自动生成的respond_to 去掉，
  # 我建议是如果发现一段代码不用，立刻删掉，因为我们用git来管理代码，所以不用担心代码删了
  # 就不好找回来
  def create
    @role = Role.new(role_params)

    respond_to do |format|
      if @role.save
        format.html { redirect_to @role, notice: 'Role was successfully created.' }
        format.json { render action: 'show', status: :created, location: @role }
      else
        format.html { render action: 'new' }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /roles/1
  # PATCH/PUT /roles/1.json
  def update
    respond_to do |format|
      if @role.update(role_params)
        format.html { redirect_to @role, notice: 'Role was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.json
  def destroy
    @role.destroy
    respond_to do |format|
      format.html { redirect_to roles_url }
      format.json { head :no_content }
    end
  end

#一般写数据库的操作都会有出错的可能，现在的逻辑是如果出错了，用户不会注意到，也许可以写成这样:
#def assign_permissions
#  ...
#  if save_permissions
#    ...
#  else
#    ...
#  end
#end
#
#private
#def save_permissions(news, olds)
#  ActiveRecord::Base.transaction do
#    news.each do |new|
#      RolePermission.create!(...)
#    end
#    olds.each do |old|
#      RolePermission.create!(...)
#    end
#  end
#  true
#rescue
#  false
#end
  def assign_permissions
    role_id = params[:role_id]
    news = params[:news].split(',')
    news.each do |n|
      RolePermission.create(role_id: role_id, permission_id: n)
    end
    deleteds = params[:deleteds].split(',')
    deleteds.each do |d|
      RolePermission.destroy_all ['role_id = ? and permission_id = ?', role_id, d]
    end
    #一般返回json也许会比较好，而且返回的json格式应该在整个项目都统一，并且有个规范
    render text: '操作成功'
  end

  def permissions
      ids = params[:ids].split(",")
      roles = Role.find(ids)
      permissions = []
      roles.each do |role|
          permissions.concat role.permissions
      end
      render json: permissions
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def role_params
      params.require(:role).permit(:name)
    end
end
