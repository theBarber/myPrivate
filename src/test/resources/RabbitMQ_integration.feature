@S3
Feature: RMQ_integration
  @Sanity
  Scenario: Put request on RabbitMQ and getting possitive reply from RabbitMQ with one of the banners id
    When When putting a de.rabbitmq.request_message on RMQ with banner ID BI  which satisfy criteria A
    Then The RMQ should return reply (out) with  banner id BI