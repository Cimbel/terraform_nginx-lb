# terraform_nginx-lb

Here is an nginx server which is a loadbalancer \
for two apache servers.\
Everything runing in AWS cloud by using terraform.\
\
Resources which have launched in AWS by terraform:
* EC2 Apache instance ( quantity 2 )
* EC2 Nginx instance ( quantity 1 )
* Security group ( quantity 1 )
* Key pair ( quantity 1 )

\
Additional info:
1. After all instances are configured,\
all their ip addresses is saved in txt file.
2. Key pair you using those which you have generated\
on your computer for providing reliable security\
connection to instances which terraform has created.
