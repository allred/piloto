require_relative 'spec_helper'
require 'piloto'

class PilotoTest < Minitest::Test
  def setup
    @piloto = Piloto.new
  end

  def test_piloto
    assert Piloto.dir_log != nil
    assert Piloto.dir_scripts != nil
  end

  def test_ruby_scripts_compile
    Dir.glob('scripts/*') do |s|
      if File.stat(s).executable? && File.open(s, &:gets) =~ /ruby/
        rval = %x(ruby -c #{s})
        assert $?.success? == true
      end
    end
  end

  def test_migrations_compile
    Dir.glob('db/migrations/*') do |s|
      rval = %x(ruby -c #{s})
      assert $?.success? == true
    end
  end
end
