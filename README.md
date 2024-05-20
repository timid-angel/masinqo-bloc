# Masinqo

## Group Members

| Full Name | ID | Github |
| ---- | ---- | ---- |
| Lidiya Mamo Kibret | UGR/2485/14 | Lidiya-MK |
| Mati Milkessa Ensermu | UGR/0949/14 | RealMati |
| Natanim Kemal Abdela | UGR/4648/14 | Natanim-Kemal |
| Nathan Mesfin Shiferaw | UGR/0534/14 | timid-angel |

## Description
Masinqo is a music-sharing platform where artists can upload their works to a public platform where tracks are downloaded/streamed by a general audience. The platform is motivated by the current musical atmosphere in which big streaming platforms continue to rise while pushing the most established musicians and bands without making special provisions for underground/local scenes. Music is a big part of culture, and we believe that the general trend toward Western ideologies should not belittle the identity of any nation. This platform aims to uplift the discoverability of independent artists so that they may openly release their works to a platform that provides an even playing field regardless of their popularity or past achievements.

## Authentication and Role-based Authorization Overview
1. User Registration: Artists and Listeners alike are able to create a new account and sign up to the platform by providing their credentials.
2. Authentication: The system has an authentication subsystem that lays the foundation for the user-specific features of Masinqo and any underlying access-control requirements. 
3. Authorization and Role-based CRUD Features: The CRUD operations will be protected by authorization to protect the user-generated assets and user data from being accessed by unauthorized parties.
4. Role Assignment: The system will provide an interface where the roles of an artist’s or a listener’s system may be changed. Included in this interface is the ability of the admin to ban accounts and restrict a certain account from accessing the features of the system.

## Feature 1 - Artists
- Create an account
- Login with an existing account
- Create albums with album arts
- Add songs to created albums
- Delete songs from created albums
- Update the details of an album after its creation
- Delete albums

## Feature 2 - Listeners
- Create an account
- Login with an existing account
- Add albums to their ‘Favorite’ lists
- Create playlists
- Add songs to created playlists
- Delete songs from created playlists
- Update the details of the playlist after creation
- Delete playlists


## Feature 3 - Admins and Account Management
- Access the users in the system
- Update user information, including login credentials
- Ban accounts in the system
- Delete artist accounts and all their created albums and songs