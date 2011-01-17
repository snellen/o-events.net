class StartBlocksController < ApplicationController
  # GET /start_blocks
  # GET /start_blocks.xml
  def index
    @start_blocks = StartBlock.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @start_blocks }
    end
  end

  # GET /start_blocks/1
  # GET /start_blocks/1.xml
  def show
    @start_block = StartBlock.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @start_block }
    end
  end

  # GET /start_blocks/new
  # GET /start_blocks/new.xml
  def new
    @start_block = StartBlock.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @start_block }
    end
  end

  # GET /start_blocks/1/edit
  def edit
    @start_block = StartBlock.find(params[:id])
  end

  # POST /start_blocks
  # POST /start_blocks.xml
  def create
    @start_block = StartBlock.new(params[:start_block])

    respond_to do |format|
      if @start_block.save
        format.html { redirect_to(@start_block, :notice => 'Start block was successfully created.') }
        format.xml  { render :xml => @start_block, :status => :created, :location => @start_block }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @start_block.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /start_blocks/1
  # PUT /start_blocks/1.xml
  def update
    @start_block = StartBlock.find(params[:id])

    respond_to do |format|
      if @start_block.update_attributes(params[:start_block])
        format.html { redirect_to(@start_block, :notice => 'Start block was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @start_block.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /start_blocks/1
  # DELETE /start_blocks/1.xml
  def destroy
    @start_block = StartBlock.find(params[:id])
    @start_block.destroy

    respond_to do |format|
      format.html { redirect_to(start_blocks_url) }
      format.xml  { head :ok }
    end
  end
end
