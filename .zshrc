alias ll="exa -la"
alias vim="nvim"

bak() {
    cp "$1" "$1.bak"
}

source "$HOME/sdks/cmd.sh"


gitid_tudelft() {
    git config user.name "Lluís Merlos Pieri"
    git config user.email "L.MerlosPieri@student.tudelft.nl"

    git config user.name
    git config user.email
}

gitid_llmerlos() {
    git config user.name "Lluís Merlos Pieri"
    git config user.email "llmerlos@outlook.com"

    git config user.name 
    git config user.email
}
