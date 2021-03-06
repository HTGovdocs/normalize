require 'normalize'

RSpec.describe '#normalize_lccn' do
  # examples taken from http://www.loc.gov/marc/lccn-namespace.html
  it "correctly normalizes" do
    expect(Normalize.lccn("n78-890351")).to eq("n78890351")
    expect(Normalize.lccn("n78-89035")).to eq("n78089035")
    expect(Normalize.lccn("n 78890351 ")).to eq("n78890351")
    expect(Normalize.lccn(" 85000002 ")).to eq("85000002")
    expect(Normalize.lccn("85-2 ")).to eq("85000002")
    expect(Normalize.lccn("2001-000002")).to eq("2001000002")
    expect(Normalize.lccn("75-425165//r75")).to eq("75425165")
    expect(Normalize.lccn(" 79139101 /AC/r932")).to eq("79139101")
  end
end

 
