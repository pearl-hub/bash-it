
post_install() {
    local giturl=https://github.com/Bash-it/bash-it.git

    info "Installing or updating the ${PEARL_PKGNAME} git repository..."
    install_or_update_git_repo $giturl "${PEARL_PKGVARDIR}/bash_it" master

    ${PEARL_PKGVARDIR}/bash_it/install.sh --no-modify-config

    setup_configuration "${PEARL_PKGVARDIR}/config.bash" \
        _new_config _apply_config _unapply_config

    return 0
}

post_update() {
    post_install
}

pre_remove() {
    rm -rf "$PEARL_PKGVARDIR/bash_it"
    return 0
}

_new_config() {
    cd "$PEARL_PKGVARDIR/bash_it/themes/"
    local themes=()
    local thm
    for thm in *
    do
        themes+=("$thm")
    done

    local theme=$(choose "Which theme for bash-it would you like?" "" "${themes[@]}")
    sed -e "s/<THEME>/$theme/g" "$PEARL_PKGDIR/config-template.bash" > "$PEARL_PKGVARDIR/config.bash"

    return 0
}

_apply_config() {
    :
}

_unapply_config() {
    :
}
