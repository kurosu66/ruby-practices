# frozen_string_literal: true

class Option
  def initialize(params)
    # 渡されたオプションに応じてメソッドに渡す

    current_dir_items =
      if params['a']
        Dir.glob('*', File::FNM_DOTMATCH)
      else
        Dir.glob('*')
      end
  end

  def a_option

  end

  def r_opiton

  end

  def l_option

  end
end
