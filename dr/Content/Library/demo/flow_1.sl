namespace: demo
flow:
  name: flow_1
  workflow:
    - append:
        do:
          demo.append: []
        navigate:
          - SUCCESS: substring
    - substring:
        do:
          demo.substring:
            - origin_string: x
        navigate:
          - SUCCESS: substring_1
          - FAILURE: on_failure
    - substring_1:
        do:
          demo.substring:
            - origin_string: x
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: CUSTOM
  results:
    - SUCCESS
    - FAILURE
    - CUSTOM
extensions:
  graph:
    steps:
      append:
        x: 80
        'y': 80
      substring:
        x: 240
        'y': 200
      substring_1:
        x: 440
        'y': 200
        navigate:
          fbb89057-32b8-7f17-cc65-638b806f2a06:
            targetId: 4ae6eff3-1b89-52be-fcee-dacef2fd9d14
            port: SUCCESS
          0f97b5a0-6eb3-1cf0-65df-889f876a1f3c:
            targetId: b6b79e2b-51f8-930e-b03b-157a1a8c56ea
            port: FAILURE
    results:
      SUCCESS:
        4ae6eff3-1b89-52be-fcee-dacef2fd9d14:
          x: 600
          'y': 80
      CUSTOM:
        b6b79e2b-51f8-930e-b03b-157a1a8c56ea:
          x: 640
          'y': 320
