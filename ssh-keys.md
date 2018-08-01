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

Add all the public keys to `~/.ssh/authorized_keys` by copy pasting public keys to end of file.

Also, add the private keys to `ssh-agent`

```
ssh-add -K ~/.ssh/id_rsa.home
ssh-add -K ~/.ssh/id_rsa.work
```

[1](https://serverfault.com/questions/221760/multiple-public-keys-for-one-user)
[2](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/#adding-your-ssh-key-to-the-ssh-agent)