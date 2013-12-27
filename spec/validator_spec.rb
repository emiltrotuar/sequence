describe Validator do
  context 'validation errors' do
    it 'validates an array' do
      array = [:first, :second, 'third', 4]
      expect do 
        validator.validate_array(array)
      end.to raise_error('array should only consists of symbols')
    end

    it 'validates iteration' do
      expect do 
        validator.validate_iteration(current_index, array_of_items)
      end.to raise_error('array should only consists of symbols')
    end

    it 'assings a values of proper type' do
      expect do 
        validator.check_type('first')
      end.to raise_error('assigned value should be a symbol')
    end

    it 'checks if item belongs to array' do
      expect do 
        validator.check_index(:fifth)
      end.to raise_error('wrong assignment')
    end
  end
end