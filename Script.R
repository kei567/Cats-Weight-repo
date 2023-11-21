# visualization of dat.csv
library(ggplot2)
library(dslabs)
library(ggthemes) 

ds_theme_set()

library(ggplot2)

# CSVファイルを読み込む
data <- read.csv("/path/to/your/dat.csv")

# 日付の列をDate型に変換
data$Date <- as.Date(data$Date)

# ggplotを使用してデータを可視化
ggplot(data) +
  geom_line(aes(x = Date, y = Owner, colour = "Owner Weight")) +
  geom_point(aes(x = Date, y = Owner, colour = "Owner Weight")) +
  geom_line(aes(x = Date, y = Cat, colour = "Cat Weight"), na.rm = TRUE) +
  geom_point(aes(x = Date, y = Cat, colour = "Cat Weight"), na.rm = TRUE) +
  labs(title = "Weight Tracking", x = "Date", y = "Weight (lbs)") +
  scale_colour_manual(values = c("Owner Weight" = "blue", "Cat Weight" = "red"))

# 二軸で表示する
# 最初のY軸（左側）の最大値と最小値を計算
left_y_min <- min(data$Owner, na.rm = TRUE)
left_y_max <- max(data$Owner, na.rm = TRUE)

# オーナーの体重変化の範囲を取得
owner_range <- max(data$Owner, na.rm = TRUE) - min(data$Owner, na.rm = TRUE) + 40

# 猫の体重変化の範囲を取得
cat_range <- max(data$Cat, na.rm = TRUE) - min(data$Cat, na.rm = TRUE)

# 右Y軸のスケールを調整するための係数を計算（猫の体重データをオーナーの体重データのスケールに合わせる）
right_y_factor <- owner_range / cat_range

# ggplotを使用して二軸グラフを作成
ggplot(data, aes(x = Date)) +
  # geom_line(aes(y = Owner, colour = "Owner Weight")) +
  geom_point(aes(y = Owner, colour = "Owner Weight")) +
  geom_smooth(aes(y = Owner, colour = "Owner Weight"), se = FALSE) +
  # geom_line(aes(y = Cat * right_y_factor, colour = "Cat Weight")) +
  geom_point(aes(y = Cat * right_y_factor, colour = "Cat Weight")) +
  geom_smooth(aes(y = Cat * right_y_factor, colour = "Cat Weight"), se = FALSE) +
  scale_y_continuous(
    name = "Owner Weight (lbs)", 
    sec.axis = sec_axis(~./right_y_factor, name="Cat Weight (lbs)")
  ) +
  scale_colour_manual(values = c("Owner Weight" = "blue", "Cat Weight" = "red")) +
  theme_economist() + 
  labs(title = "Weight Tracking", x = "Date")

##
# viridis package
library(ggplot2)
library(viridis) # viridisパッケージを読み込む

# CSVファイルを読み込む
# data <- read.csv("/path/to/your/dat.csv")

# 日付の列をDate型に変換
data$Date <- as.Date(data$Date)

# 右Y軸のスケールを調整するための係数を計算（ここでは仮の値を使用）
right_y_factor <- 1 # 実際には適切な値に置き換える必要があります

# ggplotを使用して二軸グラフを作成
gg <- ggplot(data, aes(x = Date)) +
  geom_line(aes(y = Owner, colour = "Owner Weight")) +
  geom_point(aes(y = Owner, colour = "Owner Weight")) +
  geom_smooth(aes(y = Owner, colour = "Owner Weight"), se = FALSE) +
  geom_line(aes(y = Cat * right_y_factor, colour = "Cat Weight")) +
  geom_point(aes(y = Cat * right_y_factor, colour = "Cat Weight")) +
  geom_smooth(aes(y = Cat * right_y_factor, colour = "Cat Weight"), se = FALSE) +
  scale_y_continuous(
    name = "Owner Weight (lbs)", 
    sec.axis = sec_axis(~./right_y_factor, name="Cat Weight (lbs)")
  ) +
  labs(title = "Weight Tracking", x = "Date", y = "Weight (lbs)") +
  scale_colour_viridis(discrete = TRUE, option = "D") + # viridisカラーパレットを適用
  theme_minimal() # ミニマルなテーマを適用

# コードを実行
print(gg)

