# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../bin/ls'

class Lstest < Minitest::Test
  def test_ls_without_options
    expected = <<~TEXT.chomp
      01.fizzbuzz/		03.bowling/		05.wc/			07.ls_object/		99.wc_object/		README.md
      02.calendar/		04.ls/			06.bowling_object/	98.rake/		Gemfile
    TEXT
    assert_equal expected, run_ls
  end

  def test_ls_with_a_option
    expected = <<~TEXT.chomp
    ./			.DS_Store		.gitignore		.rubocop.yml		02.calendar/		04.ls/			06.bowling_object/	98.rake/		Gemfile
    ../			.git/			.idea/			01.fizzbuzz/		03.bowling/		05.wc/			07.ls_object/		99.wc_object/		README.md
    TEXT
    assert_equal expected, run_ls
  end

  def test_ls_with_r_option
    expected = <<~TEXT.chomp
    README.md		99.wc_object/		07.ls_object/		05.wc/			03.bowling/		01.fizzbuzz/
    Gemfile			98.rake/		06.bowling_object/	04.ls/			02.calendar/
    TEXT
    assert_equal expected, run_ls
  end

  def test_ls_with_l_option
    expected = <<~TEXT.chomp
    total 16
    drwxr-xr-x  3 kurosu  staff    96 Apr 19 09:21 01.fizzbuzz/
    drwxr-xr-x  3 kurosu  staff    96 Apr 19 09:21 02.calendar/
    drwxr-xr-x  3 kurosu  staff    96 Apr 19 15:58 03.bowling/
    drwxr-xr-x  3 kurosu  staff    96 Jul 20 15:43 04.ls/
    drwxr-xr-x  3 kurosu  staff    96 Apr 19 09:21 05.wc/
    drwxr-xr-x  9 kurosu  staff   288 Jul 20 15:35 06.bowling_object/
    drwxr-xr-x  6 kurosu  staff   192 Jul 22 19:44 07.ls_object/
    drwxr-xr-x  3 kurosu  staff    96 Apr 19 09:21 98.rake/
    drwxr-xr-x  3 kurosu  staff    96 Apr 19 09:21 99.wc_object/
    -rw-r--r--  1 kurosu  staff    72 Jun 19 22:51 Gemfile
    -rw-r--r--  1 kurosu  staff  2648 Apr 19 09:21 README.md
    TEXT
    assert_equal expected, run_ls
  end

  def test_ls_with_a_r_option
    expected = <<~TEXT.chomp
    README.md		99.wc_object/		07.ls_object/		05.wc/			03.bowling/		01.fizzbuzz/		.idea/			.git/			../
    Gemfile			98.rake/		06.bowling_object/	04.ls/			02.calendar/		.rubocop.yml		.gitignore		.DS_Store		./
    TEXT
    assert_equal expected, run_ls
  end

  def test_ls_with_a_l_option
    expected = <<~TEXT.chomp
    total 56
    drwxr-xr-x   18 kurosu  staff   576 Jun 24 19:01 ./
    drwxr-xr-x+ 111 kurosu  staff  3552 Jul 23 13:56 ../
    -rw-r--r--@   1 kurosu  staff  8196 Jun 24 19:01 .DS_Store
    drwxr-xr-x   15 kurosu  staff   480 Jul 23 13:55 .git/
    -rw-r--r--    1 kurosu  staff  2090 Apr 19 09:21 .gitignore
    drwxr-xr-x    6 kurosu  staff   192 Jul 23 13:56 .idea/
    -rw-r--r--    1 kurosu  staff    57 Apr 19 09:21 .rubocop.yml
    drwxr-xr-x    3 kurosu  staff    96 Apr 19 09:21 01.fizzbuzz/
    drwxr-xr-x    3 kurosu  staff    96 Apr 19 09:21 02.calendar/
    drwxr-xr-x    3 kurosu  staff    96 Apr 19 15:58 03.bowling/
    drwxr-xr-x    3 kurosu  staff    96 Jul 20 15:43 04.ls/
    drwxr-xr-x    3 kurosu  staff    96 Apr 19 09:21 05.wc/
    drwxr-xr-x    9 kurosu  staff   288 Jul 20 15:35 06.bowling_object/
    drwxr-xr-x    6 kurosu  staff   192 Jul 22 19:44 07.ls_object/
    drwxr-xr-x    3 kurosu  staff    96 Apr 19 09:21 98.rake/
    drwxr-xr-x    3 kurosu  staff    96 Apr 19 09:21 99.wc_object/
    -rw-r--r--    1 kurosu  staff    72 Jun 19 22:51 Gemfile
    -rw-r--r--    1 kurosu  staff  2648 Apr 19 09:21 README.md
    TEXT
    assert_equal expected, run_ls
  end

  def test_ls_with_r_l_option
    expected = <<~TEXT.chomp
    total 16
    -rw-r--r--  1 kurosu  staff  2648 Apr 19 09:21 README.md
    -rw-r--r--  1 kurosu  staff    72 Jun 19 22:51 Gemfile
    drwxr-xr-x  3 kurosu  staff    96 Apr 19 09:21 99.wc_object/
    drwxr-xr-x  3 kurosu  staff    96 Apr 19 09:21 98.rake/
    drwxr-xr-x  6 kurosu  staff   192 Jul 22 19:44 07.ls_object/
    drwxr-xr-x  9 kurosu  staff   288 Jul 20 15:35 06.bowling_object/
    drwxr-xr-x  3 kurosu  staff    96 Apr 19 09:21 05.wc/
    drwxr-xr-x  3 kurosu  staff    96 Jul 20 15:43 04.ls/
    drwxr-xr-x  3 kurosu  staff    96 Apr 19 15:58 03.bowling/
    drwxr-xr-x  3 kurosu  staff    96 Apr 19 09:21 02.calendar/
    drwxr-xr-x  3 kurosu  staff    96 Apr 19 09:21 01.fizzbuzz/
    TEXT
    assert_equal expected, run_ls
  end

  def test_ls_with_a_r_l_option
    expected = <<~TEXT.chomp
    total 56
    -rw-r--r--    1 kurosu  staff  2648 Apr 19 09:21 README.md
    -rw-r--r--    1 kurosu  staff    72 Jun 19 22:51 Gemfile
    drwxr-xr-x    3 kurosu  staff    96 Apr 19 09:21 99.wc_object/
    drwxr-xr-x    3 kurosu  staff    96 Apr 19 09:21 98.rake/
    drwxr-xr-x    6 kurosu  staff   192 Jul 22 19:44 07.ls_object/
    drwxr-xr-x    9 kurosu  staff   288 Jul 20 15:35 06.bowling_object/
    drwxr-xr-x    3 kurosu  staff    96 Apr 19 09:21 05.wc/
    drwxr-xr-x    3 kurosu  staff    96 Jul 20 15:43 04.ls/
    drwxr-xr-x    3 kurosu  staff    96 Apr 19 15:58 03.bowling/
    drwxr-xr-x    3 kurosu  staff    96 Apr 19 09:21 02.calendar/
    drwxr-xr-x    3 kurosu  staff    96 Apr 19 09:21 01.fizzbuzz/
    -rw-r--r--    1 kurosu  staff    57 Apr 19 09:21 .rubocop.yml
    drwxr-xr-x    6 kurosu  staff   192 Jul 23 13:57 .idea/
    -rw-r--r--    1 kurosu  staff  2090 Apr 19 09:21 .gitignore
    drwxr-xr-x   15 kurosu  staff   480 Jul 23 13:57 .git/
    -rw-r--r--@   1 kurosu  staff  8196 Jun 24 19:01 .DS_Store
    drwxr-xr-x+ 111 kurosu  staff  3552 Jul 23 13:57 ../
    drwxr-xr-x   18 kurosu  staff   576 Jun 24 19:01 ./
    TEXT
    assert_equal expected, run_ls
  end
end
