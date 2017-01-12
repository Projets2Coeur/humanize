require 'spec_helper'
require 'bigdecimal/util'

describe "Humanize" do
  require_relative 'tests'

  after(:each) do
    Humanize.reset_config
  end

  TESTS.each do |num, human|
    it "#{num} is #{human}" do
      expect(num.humanize).to eql(human)
    end
  end

  describe 'locale option' do

    it 'uses default locale' do
      Humanize.config.default_locale = :fr
      expect(42.humanize).to eql('quarante-deux')
    end

    it 'uses locale passed as argument if given' do
      Humanize.config.default_locale = :en
      expect(42.humanize(:locale => :fr)).to eql('quarante-deux')
    end

    describe 'french specific rules' do

      it 'one thousand and one equals "mille un"' do
        expect(1002.humanize(:locale => :fr)).to eql('mille deux')
      end

      it 'two thousand and one equals "deux mille un"' do
        expect(2001.humanize(:locale => :fr)).to eql('deux mille un')
      end

      it 'ten thousand equals "dix mille"' do
        expect(2001.humanize(:locale => :fr)).to eql('deux mille un')
      end

    end

  end

  describe 'decimals_as option' do

    it 'uses value from configuration' do
      Humanize.config.decimals_as = :number
      expect(0.42.humanize).to eql('zero point forty-two')
    end

    it 'uses value passed as argument if given' do
      Humanize.config.decimals_as = :number
      expect(0.42.humanize(:decimals_as => :digits)).to eql('zero point four two')
    end

    it 'works with BigDecimal' do
      Humanize.config.decimals_as = :number
      expect(0.42.to_d.humanize).to eql('zero point forty-two')
    end

  end

  describe 'both options work together' do

    it 'work together' do
      expect(
        0.42.humanize(:locale => :fr, :decimals_as => :number)
      ).to eql('zéro virgule quarante-deux')
    end

  end

end
