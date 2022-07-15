setwd("/Users/ryo/Documents/R/R_study/lissajous/input")
library(tuneR)

win_lng <- 10 ## ms
n <- 1 / sqrt(2)
sec <- 1


pwd <- sprintf("%s", getwd())
fnames <- list.files(path = pwd, pattern = "*.wav")
par(mfrow = c(3, 2), mar = c(1, 1, 0.5, 0.5))

for (fname in fnames) {
  wav_l <- readWave(fname)@left
  wav_r <- readWave(fname)@right
  fs <- readWave(fname)@samp.rate
  ln <- length(wav_l) * sec / 8
  win_ln <- round(win_lng * (fs / 1000))
  index <- 1

  setwd("/Users/ryo/Documents/R/R_study/lissajous/output")
  pdf(sprintf("%s.pdf", substring(fname, 1, (nchar(fname) - 4)))) # , width = 600, height = 600)
  par(mfrow = c(3, 2), mar = c(1, 1, 0.5, 0.5))
  count <- 1
  while (index < ln) {
    sig_l <- wav_l[index:(index + win_ln)]
    sig_r <- wav_r[index:(index + win_ln)]
    modx <- sig_l * n - sig_r * n
    mody <- sig_l * n + sig_r * n
    # plot(modx, mody, type = "l", xlim = c(-40000, 40000), ylim = c(-40000, 40000), xlab = "", ylab = "") # nolint
    if (count %% 8 == 0) {
      plot(modx, mody,
        type = "p",
        xlab = "", ylab = "",
        xlim = c(-0.6, 0.6), ylim = c(-0.6, 0.6),
        xaxt = "n", yaxt = "n" # ,
        # main = sprintf("%s", fname)
      )
    }
    # grid()
    index <- index + win_ln
    count <- count + 1
  }
  dev.off()
  setwd("/Users/ryo/Documents/R/R_study/lissajous/input")
}
