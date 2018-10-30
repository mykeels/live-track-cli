# Live-Track CLI

A set of command-line (unix) programs for accessing vehicle GPS tracking data on [Live-Track.NET](https://live-track.net). You'd need an account with Live-Track to use this tool.

## Dependencies

- NodeJS (for parsing JSON)

## Usage

- Clone this repository
- In your local folder, run `sh ./location.sh`
  - Enter your login username and password, to view your vehicle location info

If you don't want to enter your credentials everytime, You should set `LIVETRACK_USERNAME` and `LIVETRACK_PASSWORD` environment variables to your login username and password.