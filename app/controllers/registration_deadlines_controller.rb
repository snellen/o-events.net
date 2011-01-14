class RegistrationDeadlinesController < ApplicationController
  # GET /registration_deadlines
  # GET /registration_deadlines.xml
  def index
    @registration_deadlines = RegistrationDeadline.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @registration_deadlines }
    end
  end

  # GET /registration_deadlines/1
  # GET /registration_deadlines/1.xml
  def show
    @registration_deadline = RegistrationDeadline.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @registration_deadline }
    end
  end

  # GET /registration_deadlines/new
  # GET /registration_deadlines/new.xml
  def new
    @registration_deadline = RegistrationDeadline.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @registration_deadline }
    end
  end

  # GET /registration_deadlines/1/edit
  def edit
    @registration_deadline = RegistrationDeadline.find(params[:id])
  end

  # POST /registration_deadlines
  # POST /registration_deadlines.xml
  def create
    @registration_deadline = RegistrationDeadline.new(params[:registration_deadline])

    respond_to do |format|
      if @registration_deadline.save
        format.html { redirect_to(@registration_deadline, :notice => 'Registration deadline was successfully created.') }
        format.xml  { render :xml => @registration_deadline, :status => :created, :location => @registration_deadline }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @registration_deadline.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /registration_deadlines/1
  # PUT /registration_deadlines/1.xml
  def update
    @registration_deadline = RegistrationDeadline.find(params[:id])

    respond_to do |format|
      if @registration_deadline.update_attributes(params[:registration_deadline])
        format.html { redirect_to(@registration_deadline, :notice => 'Registration deadline was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @registration_deadline.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /registration_deadlines/1
  # DELETE /registration_deadlines/1.xml
  def destroy
    @registration_deadline = RegistrationDeadline.find(params[:id])
    @registration_deadline.destroy

    respond_to do |format|
      format.html { redirect_to(registration_deadlines_url) }
      format.xml  { head :ok }
    end
  end
end
