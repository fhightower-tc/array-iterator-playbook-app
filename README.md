# Array Iterator

## Summary

Iterate through an array and send each item in the array to a playbook trigger link.

## Dependencies

- requests
- tcex

## Input Definitions

- `Array`: The array through which you would like to iterate.
- `Playbook Trigger Link`: The playbook link to which you would like to send each item in the array.

## Installing in ThreatConnect

To install this app in ThreatConnect, run the following code in the top-level directory of this app:

```shell
make lib
make pack
```

This will create a `.tcx` file in the top app directory which will work in ThreatConnect assuming the instance of ThreatConnect is running the same version of python used during the `make lib` command.

## Credits

This package was created with [Cookiecutter](https://github.com/audreyr/cookiecutter) and [Floyd Hightower's TCEX App Template](https://gitlab.com/fhightower-templates/tcex-app-template).
