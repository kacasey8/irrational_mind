class IrrationalsController < ApplicationController
  before_action :set_irrational, only: [:show, :edit, :update, :destroy]

  # GET /irrationals
  # GET /irrationals.json
  def index
    @irrationals = Irrational.all
  end

  # GET /irrationals/1
  # GET /irrationals/1.json
  def show
  end

  # GET /irrationals/new
  def new
    @irrational = Irrational.new
  end

  # GET /irrationals/1/edit
  def edit
  end

  # POST /irrationals
  # POST /irrationals.json
  def create
    @irrational = Irrational.new(irrational_params)

    set_exact
    implant_fractions
    respond_to do |format|
      if @irrational.save
        format.html { redirect_to @irrational, notice: 'Irrational was successfully created.' }
        format.json { render action: 'show', status: :created, location: @irrational }
      else
        format.html { render action: 'new' }
        format.json { render json: @irrational.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /irrationals/1
  # PATCH/PUT /irrationals/1.json
  def update
    respond_to do |format|
      if @irrational.update(irrational_params)
        set_exact
        implant_fractions
        format.html { redirect_to @irrational, notice: 'Irrational was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @irrational.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /irrationals/1
  # DELETE /irrationals/1.json
  def destroy
    @irrational.destroy
    respond_to do |format|
      format.html { redirect_to irrationals_url }
      format.json { head :no_content }
    end
  end

  def set_exact
    return unless @irrational.valid?
    a = @irrational.input.frac
    @irrational.exact_numerator = a.numerator + @irrational.input.to_i * a.denominator
    @irrational.exact_denominator = a.denominator
    @irrational.save
  end

  def implant_fractions
    @irrational.fractions.delete_all # clear out potentially old data
    a = @irrational.input.frac
    min_rational = 0.to_r
    min_tolerance = (min_rational - a).abs
    current_numerator = min_rational.numerator
    current_denominator = min_rational.denominator

    min_numerator = min_rational.numerator
    min_denominator = min_rational.denominator
    max_iterations = 10000
    current_test = current_numerator.to_f/current_denominator
    seen_significance = -1
    (1..max_iterations).each do
      if current_test < a
        current_numerator += 1
      else
        current_denominator += 1
      end
      current_test = current_numerator.to_f/current_denominator
      test_tolerance = (current_test - a).abs
      if test_tolerance < min_tolerance # found a closer value
        min_rational = current_test
        min_tolerance = test_tolerance
        min_numerator = current_numerator
        min_denominator = current_denominator
        sign, significant_digits, base, exponent = test_tolerance.split
        if significant_digits == "0"  # perfect match
          return Fraction.create(numerator: min_numerator, denominator: min_denominator, error: min_tolerance, irrational_id: @irrational.id)
        elsif exponent < seen_significance # a match on a better magnitude, record this fit
          Fraction.create(numerator: min_numerator, denominator: min_denominator, error: min_tolerance, irrational_id: @irrational.id)
          seen_significance = exponent
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_irrational
      @irrational = Irrational.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def irrational_params
      params.require(:irrational).permit(:input, :exact_numerator, :exact_denominator)
    end
end
