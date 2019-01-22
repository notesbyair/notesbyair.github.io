---
layout: post
title: Skype-Study
description: >
 A big-picture on why Skype worsk so fast!
author: author1
comments: true
cover: false
---
[Skype](https://www.skype.com/en/) is Similar to Yahoo Chat, Google Chat, and IM chat, etc., but I was wondering why Skype performance is better than compared to other. How really it works? Skype protocol is not open-source, but many tried to reverse engineer. I read some well-cited papers on Skype Architecture, here is a simple version of How your favorite Skype works?

Skype can be seen as a peer-peer distributed network, means it is something similar to Torrent application, where the peer-peer network is used to download movies, music, files etc.

Skype uses following technique to make connections between two Skype accounts.
> It establish direct connections between two PCs, tough they are on NAT. That's why I see its so fast. Say your internet modem is behind the NAT, then you can open ports, but no one outside the world can connect your system because of [NAT](https://en.wikipedia.org/wiki/Network_address_translation) blocks it. 
 
So you need someway to open it to your friend to talk. We can use many ways, one is UDP punch hole technique.  **The main point is that, if you open the connection once, then we can use that opened connection to communicate directly without any  server in between.**

But to establish the connection, we need a third party server to make that *first connection*. In general, the technique is called [UDP hole punching](https://en.wikipedia.org/wiki/UDP_hole_punching).  

> Skype does it in a de-centralized fashion. That means any client *who has publically reachable IP is also acting as server* - called super nodes. Using these nodes it reaches A-B connections. 

Not so easy, consider this scenerio:
{:.message}

Some NAT is really doing port randomization after it opened the connection, in this case - UDP punch hole is impossible. So they use Relay server, it's like both clients open the connection to relay server. Relay server sends client A request to Client B, vice versa.

notes to remeber: 
{:.lead}

- Skype uses Peer-Peer network for faster communication in decentralized manner.
- UDP Punch hole technique is used to establish connection between two Computers directly even if they are behind NATs.
- Relay Server - If you don't have UDP punch hole option.

Reference -
[An Analysis of the Skype Peer-to-Peer Internet Telephony Protocol](http://www1.cs.columbia.edu/~salman/publications/skype1_4.pdf)
