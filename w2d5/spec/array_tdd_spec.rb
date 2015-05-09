require 'rspec'
require 'array_tdd.rb'

describe Array do
  describe "#my_uniq" do
    let(:arr) { [1, 2, 1, 3, 3] }

    it "removes non-unique numbers" do
      expect(arr.my_uniq).to eq([1, 2, 3])
    end
  end

  describe "#two_sum" do
    let(:arr) { [-1, 0, 2, -2, 1] }
    let(:arr2) { [-1, -1, 1, 1] }

    it "finds all pairs of positions where elements sum to zero" do
      expect(arr.two_sum).to eq([[0, 4], [2, 3]])
    end

    it "finds pairs in the correct order" do
      expect(arr2.two_sum).to eq([[0, 2], [0, 3], [1, 2], [1, 3]])
    end
  end

  describe "#my_transpose" do
    let(:matrix) { [[0, 1, 2], [3, 4, 5], [6, 7, 8]] }
    let(:rectangular) { [[1, 2], [3, 4], [5, 6]] }

    it "transposes a matrix" do
      expect(matrix.my_transpose).to eq([[0, 3, 6], [1, 4, 7], [2, 5, 8]])
    end

    it "transposes a matrix with different dimensions" do
      expect(rectangular.my_transpose).to eq([[1, 3, 5], [2, 4, 6]])
    end
  end

  describe "#stock_picker" do
    let(:days) { [3, 1, 5, 2, 4] }

    it "returns the most profitable pair of days" do
      expect(days.stock_picker).to eq([1, 2])
    end
  end
end
