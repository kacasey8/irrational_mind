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
    @frac_types = [:fractions, :pi_fractions, :sqrt_fractions, :e_fractions]
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

    if @irrational.valid?
      set_exact
      implant_fractions(Fraction, @irrational.input.frac, 10000)
      implant_fractions(PiFraction, @irrational.input/Math::PI, 10000)
      implant_fractions_and_function(SqrtFraction, Proc.new { |x| Math.sqrt(x) }, :root, 2)
      implant_fractions_and_function(EFraction, Proc.new { |x| Math::E ** x }, :power, 1)
    end
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
        if @irrational.valid?
          set_exact
          implant_fractions(Fraction, @irrational.input.frac, 10000)
          implant_fractions(PiFraction, @irrational.input/Math::PI, 1000)
          implant_fractions_and_function(SqrtFraction, Proc.new { |x| Math.sqrt(x) }, :root, 2)
          implant_fractions_and_function(EFraction, Proc.new { |x| Math::E ** x }, :power, 1)
        end
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
    a = @irrational.input.frac
    @irrational.exact_numerator = a.numerator + @irrational.input.to_i * a.denominator
    @irrational.exact_denominator = a.denominator
    @irrational.save
  end

  def implant_fractions(model, value, max_iterations)
    model.where(irrational_id: @irrational.id).delete_all # clear out potentially old data
    min_tolerance = 0.1
    current_numerator = 0
    current_denominator = 1
    current_test = current_numerator.to_f/current_denominator
    seen_significance = -1
    (1..max_iterations).each do
      if current_test < value
        current_numerator += 1
      else
        current_denominator += 1
      end
      current_test = current_numerator.to_f/current_denominator
      test_tolerance = (current_test - value).abs.to_d
      if test_tolerance < min_tolerance # found a closer value
        min_tolerance = test_tolerance
        sign, significant_digits, base, exponent = test_tolerance.split
        if significant_digits == "0"  # perfect match
          return model.create(numerator: current_numerator, denominator: current_denominator, error: min_tolerance, irrational_id: @irrational.id)
        elsif exponent < seen_significance # a match on a better magnitude, record this fit
          model.create(numerator: current_numerator, denominator: current_denominator, error: min_tolerance, irrational_id: @irrational.id)
          seen_significance = exponent
        end
      end
    end
  end

  def implant_fractions_and_function(model, function, name, start)
    max_iterations = 50
    max_inner = 10

    model.where(irrational_id: @irrational.id).delete_all # clear out potentially old data

    min_tolerance = 0.1
    seen_significance = -1
    (start..max_iterations).each do |root_test|
      current_numerator = 0
      current_denominator = 1
      root_value = function.call(root_test)
      match_value = @irrational.input/root_value
      current_test = current_numerator.to_f/current_denominator
      (1..max_inner).each do
        if current_test < match_value
          current_numerator += 1
        else
          current_denominator += 1
        end
        current_test = current_numerator.to_f/current_denominator
        test_tolerance = (current_test - match_value).abs.to_d
        if test_tolerance < min_tolerance # found a closer value
          min_tolerance = test_tolerance
          sign, significant_digits, base, exponent = test_tolerance.split
          if significant_digits == "0"  # perfect match
            return model.create(name.to_sym => root_test, numerator: current_numerator, denominator: current_denominator, error: min_tolerance, irrational_id: @irrational.id)
          elsif exponent < seen_significance # a match on a better magnitude, record this fit
            model.create(name.to_sym => root_test, numerator: current_numerator, denominator: current_denominator, error: min_tolerance, irrational_id: @irrational.id)
            seen_significance = exponent
          end
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
