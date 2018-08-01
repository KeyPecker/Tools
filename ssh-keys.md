# Managing SSH Keys

I have multiple github ids to isolate my work-work from home-work.

So, I wanted to use multiple public keys 

```
ssh-keygen -t rsa -b 4096 -C "<personal-email-address>" -f ~/.ssh/id_rsa.home
```
Similarly for work,
```
ssh-keygen -t rsa -b 4096 -C "<work-email-address>" -f ~/.ssh/id_rsa.work
```

Once the public keys are generated, add them to `~/.ssh/config` file

```
Host home
Hostname <personal-email-address>
IdentityFile ~/.ssh/id_rsa.home
User <>

Host work
Hostname <work-email-address>
IdentityFile ~/.ssh/id_rsa.work
User <>
```