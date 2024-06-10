BUCKET=""

cd site-html

aws s3 sync \
    --exclude ".git/*" \
    --exclude ".gitignore" \
    --exclude ".github/*" \
    --exclude "run.sh" \
    . s3://${BUCKET}

cd ..