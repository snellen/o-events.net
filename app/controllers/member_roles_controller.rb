class MemberRolesController < ApplicationController
  # GET /member_roles
  # GET /member_roles.xml
  def index
    @member_roles = MemberRole.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @member_roles }
    end
  end

  # GET /member_roles/1
  # GET /member_roles/1.xml
  def show
    @member_role = MemberRole.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @member_role }
    end
  end

  # GET /member_roles/new
  # GET /member_roles/new.xml
  def new
    @member_role = MemberRole.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @member_role }
    end
  end

  # GET /member_roles/1/edit
  def edit
    @member_role = MemberRole.find(params[:id])
  end

  # POST /member_roles
  # POST /member_roles.xml
  def create
    @member_role = MemberRole.new(params[:member_role])

    respond_to do |format|
      if @member_role.save
        format.html { redirect_to(@member_role, :notice => 'Member role was successfully created.') }
        format.xml  { render :xml => @member_role, :status => :created, :location => @member_role }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @member_role.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /member_roles/1
  # PUT /member_roles/1.xml
  def update
    @member_role = MemberRole.find(params[:id])

    respond_to do |format|
      if @member_role.update_attributes(params[:member_role])
        format.html { redirect_to(@member_role, :notice => 'Member role was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @member_role.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /member_roles/1
  # DELETE /member_roles/1.xml
  def destroy
    @member_role = MemberRole.find(params[:id])
    @member_role.destroy

    respond_to do |format|
      format.html { redirect_to(member_roles_url) }
      format.xml  { head :ok }
    end
  end
end
