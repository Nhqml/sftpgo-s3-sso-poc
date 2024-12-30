#/bin/bash

set -eo pipefail

# Wait for MinIO to be ready
until (mc alias set local ${MC_HOST} ${MC_ACCESS_KEY} ${MC_SECRET_KEY}); do
    echo 'Waiting for MinIO to be ready...';
    sleep 2;
done;

mc mb --ignore-existing local/sftpgo

mc admin user add local sftpgo sftpgosecretkey
cat <<EOF > policy.json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetBucketLocation",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::sftpgo"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:PutObject",
                "s3:DeleteObject"
            ],
            "Resource": [
                "arn:aws:s3:::sftpgo/*"
            ]
        }
    ]
}
EOF
mc admin policy create local sftpgo policy.json

mc admin policy attach local sftpgo --user sftpgo
