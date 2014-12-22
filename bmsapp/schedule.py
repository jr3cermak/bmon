'''This module holds the Schedule class.  The Schedule class identifies time periods
when a facility is occcupied and unoccupied.
'''
from datetime import datetime
import pytz, calendar
from dateutil import parser

class Schedule:
    '''This class represents an occupied/unoccupied schedule for a facility.
    '''

    def __init__(self, schedule_description, tz_name):
        '''Constructs a Schedule object.

        'schedule_description' is a string that describes the occupied periods
            of the schedule.  The format is described below.

        'tz_name' is the name of the timezone (as a string) where the facility
            is located.  'tz_name' must be available in the pytz timezone database.
            An exmaple value is 'US/Alaska'.
        '''

        # Create a timezone object and store for later use.
        self.tz = pytz.timezone(tz_name)

    def is_occupied(self, ts):
        '''Returns True if the Unix timestamp, 'ts', falls within an occupied
        period identified by this schedule.  Returns False otherwise.
        '''
        # to convert the timestamp 'ts' to a Python datetime object in the 
        # facility's time zone, use:
        dt = datetime.fromtimestamp(ts, self.tz)

        # if you need to convert a Python datetime (a datetime object *with* a 
        # timezone, not a "naive" datetime) back to a timestamp, use:
        a_ts = calendar.timegm(dt.utctimetuple())
        # although, this drops fractional seconds, which is OK for our application.

        # another useful package is the 'dateutil' package.  I imported the 
        # 'parser' module from that above.  You can create datetime objects ('naive')
        # from text strings using that module.  Even partial strings work like:
        dt_parsed = parser.parse('3:40a')
        # missing components are filled in with today's date. The parser is pretty 
        # forgiving about the presence/absence of spaces and other formatting issues.

        return True

    def occupied_periods(self, ts_start, ts_end):
        '''Returns a list of two-tuples identifying all of the occupied periods
        falling in the range from 'ts_start' to 'ts_end', which are both Unix
        timestamps.  The format of the return list is:
            [ (1419276095, 1419276200), (1419276300, 1419276500), etc ]
        Each tuple gives the start and stop of an occupied period, using Unix
        timestamps.
        '''
        return [ (1419276095, 1419276200), 
                 (1419276300, 1419276500) ]