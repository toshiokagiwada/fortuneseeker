#!/usr/bin/ruby -Ku

#--------------------------------------------
#fortuneseeker
#自分と対話する不思議なプログラムらしいぞ
#細かい使い方は良くわからない
#--------------------------------------------

#---
#Fortuneクラス
#メッセージデータを扱うクラスです
#---
class Fortune

	def initialize
		@Filename = "fortune.txt"
		@message = []
		@mnum = 0
		self.open
	end

	def open
		File.open(@Filename,"r").each {|tell|
		  @message << tell.chomp
		}
	end

	def close
		file = File.open(@Filename,"w")

		@message.each do |m|
		  file.puts m
			end

		file.close
	end

	def pop
		mlen = @message.length
	  if  mlen == 0
			"ご機嫌いかが？"
		else
			@mnum = rand(mlen)
			@message[@mnum]
		end
	end

	def push tell
		@message << tell
	end

	def delete_at num
		@message.delete_at(num)
	end

	def delete_lastpop
		delete_at @mnum
	end
end

#---
#Fortune_seekerクラス
#UIを担当するクラスです
#---
class Fortune_seeker

#Fortune_seekerクラス内にFortuneインスタンスを持つ
	def initialize 
		@fortune = Fortune.new
	end

	def puts_help
		puts <<-EOS
----------------------------------------
fortuneseeker
「ばいばい」と入力すると終了します
「D」と入力するとメッセージを削除します
「H」と入力するとヘルプを表示します
----------------------------------------
		EOS
	end

#Fortuneseekerのメインループ
#抜ける時にFortuneインスタンスをクローズします
	def run
		puts_help

		while true
  		puts ""
	
			puts @fortune.pop
			tell = gets.chomp
	
		  if tell == "ばいばい"
				break
			end
	
			if tell == "D"
				@fortune.delete_lastpop
				next
			end

			if tell == "H"
				puts_help
				next
			end
	
			if tell.length != 0
				@fortune.push tell
			end
		end

		@fortune.close
	end

end

#Fortune_seekerのインスタンスを作って実行する
app = Fortune_seeker.new
app.run
