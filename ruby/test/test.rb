require_relative "../yaml_parse"

class Test
  include Jyaml

  def test
    
    @h1 = parse "data/tinymce.yml"
    ap @h1

  end


end

Test.new.test
