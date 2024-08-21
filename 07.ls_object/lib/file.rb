# frozen_string_literal: true


class File
  # attr_reader

  # def initialize
  # end

  def run_ls
    current_dir_items = Dir.glob('*')

    column_count = 3
    current_dir_items << ' ' until (current_dir_items.size % column_count).zero?

    # 1列に格納するファイル数
    row = (current_dir_items.size / column_count).ceil

    # current_dir_itemsの中で、最も大きいファイルサイズ＋固定で追加するスペース数を格納
    fixed_space_size = 7
    max_space_size = current_dir_items.max_by(&:length).length + fixed_space_size

    # 左揃えにするため、各要素に空白を追加
    space_added_items = current_dir_items.map do |items|
      each_space_size = max_space_size - items.size
      items + ' ' * each_space_size
    end

    transposed_items = space_added_items.each_slice(row).to_a.transpose

    transposed_items.each do |items|
      puts items.join('')
    end
  end


end
