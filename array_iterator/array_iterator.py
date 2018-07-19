# -*- coding: utf-8 -*-
"""Iterate through an array and send each item to a playbook trigger."""

import json
import traceback

import requests
from tcex import TcEx


def parse_arguments():
    """Parse arguments coming into the app."""
    tcex.parser.add_argument('--array', help='Array', required=True)
    tcex.parser.add_argument('--playbook_trigger_link', help='Playbook Trigger Link', required=True)
    return tcex.args


def main():
    """."""
    args = parse_arguments()
    array_string = tcex.playbook.read(args.array)
    playbook_trigger_link = tcex.playbook.read(args.playbook_trigger_link)

    # TODO: add try-except with error message here
    array = json.loads(array_string)

    tcex.log.debug('Found {} items in array: {}'.format(len(array), array))
    tcex.log.debug('Sending each item in array to {}'.format(playbook_trigger_link))

    for item in array:
        tcex.log.info('Array item: {}'.format(item))
        requests.post(playbook_trigger_link, str(item))

    tcex.exit(0)


if __name__ == "__main__":
    tcex = TcEx()
    try:
        # start the app
        main()
    except SystemExit:
        pass
    except Exception as e:  # if there are any strange errors, log it to the logging in the UI
        err = 'Generic Error.  See logs for more details ({}).'.format(e)
        tcex.log.error(traceback.format_exc())
        tcex.message_tc(err)
        tcex.exit(1)
