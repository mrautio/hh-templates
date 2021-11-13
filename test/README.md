# Test automation

Contains test cases to avoid regression bugs in the template generation.

To run tests manually:

```sh
docker build --tag hhtemplatetest --file Dockerfile . && docker run --rm --tty hhtemplatetest
```
