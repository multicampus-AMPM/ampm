FROM python:3.8-slim
COPY ./requirements.txt /home/
RUN apt-get update
RUN pip install --upgrade pip && pip install --no-cache-dir --requirement /home/requirements.txt && pip install tensorflow
RUN apt-get install -y libgomp1
ENV GIT_PYTHON_REFRESH=quiet
ENV TF_CPP_MIN_LOG_LEVEL=3
COPY ./predictor.py /home/
CMD ["python", "/home/predictor.py"]
