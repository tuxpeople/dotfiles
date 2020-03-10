cd ~/git/dotfiles
./brew.sh
source bootstrap.sh
./.macos

# Checkout all my github repos
mkdir ~/git
cd ~/git
for i in $(wget -q -O- "https://github.com/tuxpeople?tab=repositories" | grep tuxpeople | grep codeRepository | cut -d'"' -f2 | cut -d'/' -f3)
do
  git clone git@github.com:tuxpeople/$i.git
done
