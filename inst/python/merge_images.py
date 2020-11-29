# %%
import glob
from PIL import Image
import re


# %%
# pip install Pillow
# 
# @references
# https://stackoverflow.com/questions/753190/programmatically-generate-video-or-animated-gif-in-python
# https://stackoverflow.com/questions/27327513/create-pdf-from-a-list-of-images
def imgs2pdf(files, outfile):
    img, *imgs = [Image.open(f) for f in sorted(files)]
    img.save(fp=outfile, format='PDF', append_images=imgs,
             save_all=True)


def imgs2gif(files, outfile, duration = 20):
    img, *imgs = [Image.open(f) for f in sorted(files)]
    img.save(fp=outfile, format='GIF', append_images=imgs,
             save_all=True, duration=duration, loop=0)

