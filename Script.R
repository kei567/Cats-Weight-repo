# visualization of dat.csv
library(ggplot2)
library(ggsci) # ggsciパッケージを読み込む*

# CSVファイルを読み込む
data <- read.csv("dat.csv")


# 日付の列をDate型に変換
data$Date <- as.Date(data$Date)



# 
# 右Y軸のスケール係数を計算
# 実際のデータに基づいた適切な係数に調整する必要があります
right_y_factor <- 0.5*max(data$Owner, na.rm = TRUE) / max(data$Cat, na.rm = TRUE)

# ggplotを使用して二軸グラフを作成
gg <- ggplot(data, aes(x = Date)) +
  geom_point(aes(y = Owner, colour = "Owner Weight")) +
  geom_smooth(aes(y = Owner, colour = "Owner Weight"), se = FALSE) +
  geom_point(aes(y = Cat * right_y_factor, colour = "Cat Weight")) +
  geom_smooth(aes(y = Cat * right_y_factor, colour = "Cat Weight"), se = FALSE) +
  scale_y_continuous(
    name = "Owner Weight (lbs)",
    sec.axis = sec_axis(~ . / right_y_factor, name = "Cat Weight (lbs)")
  ) +
  scale_colour_npg() + # Nature Publishing Groupのカラーパレットを適用
  labs(title = "Weight Tracking", x = "Date", y = "Weight (lbs)") +
  theme_minimal()

# コードを実行
print(gg)


