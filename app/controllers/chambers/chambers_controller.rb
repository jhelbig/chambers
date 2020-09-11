require_dependency "chambers/application_controller"

module Chambers
  class ChambersController < ApplicationController
    before_action :set_chamber, only: [:show, :edit, :update, :destroy]

    # GET /chambers
    def index
      @chambers = Chamber.all
    end

    # GET /chambers/1
    def show
    end

    # GET /chambers/new
    def new
      @chamber = Chamber.new
    end

    # GET /chambers/1/edit
    def edit
    end

    # POST /chambers
    def create
      @chamber = Chamber.new(chamber_params)

      if @chamber.save
        redirect_to @chamber, notice: 'Chamber was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /chambers/1
    def update
      if @chamber.update(chamber_params)
        redirect_to @chamber, notice: 'Chamber was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /chambers/1
    def destroy
      @chamber.destroy
      redirect_to chambers_url, notice: 'Chamber was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_chamber
        @chamber = Chamber.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def chamber_params
        params.fetch(:chamber, {})
      end
  end
end
