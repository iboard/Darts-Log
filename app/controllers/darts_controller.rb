class DartsController < ApplicationController

  def index
    begin
      load_data
      respond_to do |format|
        format.html {}
        format.csv {
          send_data @reader.to_csv, :filename => 'darts.csv', :dipatch => :download
        }
      end
    rescue => e
      @error =  "Couldn't read data-file #{datafile} [#{e.inspect}]"
    end
  end

  def new
  end

  def create
    if params[:darts_file].nil?
      redirect_to root_path 
      return false
    end
    @darts_file = params[:darts_file]
    if @darts_file.content_type =~ /text/
      _f = File.open(datafile,"w")
      _f << File::read(@darts_file.tempfile.path)
      _f.close
      load_data
    else
      @error = "Wrong file type. Please upload ASCII Data"
      redirect_to root_path
      return false
    end
    render :index
  end

private

  def load_data
    begin
      @reader = EmailReader.from_file(datafile)
      @games  = @reader.games
    rescue => e
      @error = "Can't load data #{e.inspect}"
      return false
    end
    @games
  end

  def datafile
    File::expand_path("../../../tmp/results.txt",__FILE__)
  end

  def from_id
    "new"
  end
  
end
