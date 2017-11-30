require 'benchmark'
require 'stringio'

describe 'Benchmark#bm' do
  before do
    @stdout = $stdout
    $stdout = StringIO.new
  end

  after do
    $stdout = @stdout
  end

  it 'returns an Array of Benchmark::Tms instances' do
    results = Benchmark.bm do |bench|
      bench.report('x') { 10 }
      bench.report('y') { 20 }
    end

    results[0].kind_of?(Benchmark::Tms).should == true
    results[1].kind_of?(Benchmark::Tms).should == true
  end
end
