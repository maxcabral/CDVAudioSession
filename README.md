# CDVAudioSession: AVAudioSession for Cordova on iOS

A thin wrapper around AVAudioSession, currently only supporting:

  AVAudioSession setCategory: error:
  AVAudioSession setCategory: withOptions: error:

## Installation

  cordova plugin add https://github.com/maxcabral/CDVAudioSession

## Usage

  window.plugins.AudioSession.setCategoryAndOptions('AVAudioSessionCategoryPlayback',
                                                    'AVAudioSessionCategoryOptionDuckOthers|AVAudioSessionCategoryOptionAllowBluetooth')

