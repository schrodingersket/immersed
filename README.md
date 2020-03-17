Immersed Docker Image
=====================

This Docker image is based on debian:stretch.
You will need to provide a non-expired Oculus key
found in your introductory Immersed e-mail.

To run this image, execute:
```
./run.sh
```
This will grant XSession access to the running
container and run the container in `host`
network mode.

If you'd like to run the Intel Media SDK image,
set the `USE_INTEL_MEDIA_SDK` environment variable
to `true`. To utilize `nvidia-docker` and take
advantage of host GPU, set the `USE_NVIDIA_GPU`
environment variable to `true`.

Credentials are persisted in a Docker volume 
(`/root/.Immersed`, inside the container), even for
multiple Immersed versions or containers. To reset
to an unauthorized state, run
 `docker volume rm immersed` after removing all
 existing Immersed containers.

To build the Docker image, execute the following:
```
./build.sh
```

If you've provided your Immersed username and
Oculus key in `env.sh`, authorization will
automatically be performed during the build process
and persisted to the built Docker image.

Check out ImmersedVR's Discord community for more
information: https://immersedvr.com/community
