namespace: demo
flow:
  name: flow
  workflow:
    - append:
        do:
          demo.append: []
        navigate:
          - SUCCESS: SUCCESS
  results:
    - SUCCESS
extensions:
  graph:
    steps:
      append:
        x: 80
        'y': 80
        navigate:
          6fe257e8-5ba2-28ff-b820-15795732a5fa:
            targetId: 4ae6eff3-1b89-52be-fcee-dacef2fd9d14
            port: SUCCESS
    results:
      SUCCESS:
        4ae6eff3-1b89-52be-fcee-dacef2fd9d14:
          x: 440
          'y': 80
