#!/bin/sh

# LISPBrew -- shims for roswell installed LISPs.

LISP=""
script=$(basename "$0")

case $script in
    sbcl)
        LISP=sbcl-bin
        ;;
    ccl|ccl64)
        LISP=ccl-bin
        ;;
    abcl)
        LISP=abcl-bin
        ;;
    ecl)
        LISP=ecl
        ;;
    *)
        echo "Unkown lisp. LISPBrew's not ready for $0."
        exit 1
        ;;
esac

ros +Q -L $LISP -l ~/.rc.lisp run -- "$@"
