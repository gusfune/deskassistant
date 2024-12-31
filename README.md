# Upsy Desk Assistant

This is a small helper to Upsie Desk to allow both automation and manual control of an [Upsy Desky](https://github.com/tjhorner/upsy-desky) device as a Mac menu bar.

![image](https://github.com/user-attachments/assets/3a2f2ff3-e1f1-47a2-bb61-be2fc857c64e)

## Compatibility

Only works in macOS 15.0 Sequoia duh to some simple APIs. I couldn't be bothered to use older APIs. Should work fine in earlier versions.

## Usage

You will need to compile the project from the source. Should work fine from copying and running locally.

Adjust the parameters `UPSIE_DESK_ENDPOINT` in info.plist to correspond to your own Upsy Desk endpoint.

Once compiled you can automate with interval or manually configure. Right now it only cycles from High and Low settings in the predetermined interval. It's configured to only run from 9am to 5pm (local time), you should be able to change or remove this limitation from the source code.

## NOTE OF SANITY FOR OTHER DEVELOPERS

Code is messy (ignored DRY or any good practice), did as a one day project to learn more about SwiftUI. Still can't figure how linting works... I've should have built this in Electron or else...

## Copyright

This project is distrubuted as open-source non-commercial usage. Please check LICENSE for more details.

SF Symbols® is a trademark of Apple Inc., registered in the U.S. and other countries and regions.
