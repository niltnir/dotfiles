import ranger.api
import os
import subprocess
import sox

HOOK_INIT_OLD = ranger.api.hook_init
AUDIO_PID_FILE = os.path.expanduser("~/.config/ranger/plugins/audio_preview/tmp/ranger-audio.pid")
BASH_SCRIPT = os.path.expanduser("~/.config/ranger/plugins/audio_preview/play.sh")

def hook_init(fm):

    def switch_audio(signal):
        # kill audio from previous selection
        test = os.system("[ -f " + AUDIO_PID_FILE + " ]")
        if test == 0:
            os.system("kill -9 $(head -n 1 " + AUDIO_PID_FILE + " 2> /dev/null )")
            os.system("rm " + AUDIO_PID_FILE)

        # if the new selection is an audio file, play it
        mime_type = os.popen("file --dereference --brief --mime-type -- \"" + signal.new.path + "\"").read()
        if mime_type.strip() == "audio/mpeg":
            play_new_audio(signal.new.path)

    def play_new_audio(path):
        audio_length = sox.file_info.duration(path)
        startpoint = 0
        if float(str(audio_length)) >= 600:
            startpoint = 300
        else:
            startpoint = round(float(str(audio_length)) / 2)
        subprocess.Popen([BASH_SCRIPT, path, str(startpoint), AUDIO_PID_FILE])

    fm.signal_bind('move', switch_audio)

    HOOK_INIT_OLD(fm)

ranger.api.hook_init = hook_init
