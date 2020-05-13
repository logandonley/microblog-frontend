import Rox from 'rox-browser'

export const Flags = {
  sidebar: new Rox.Flag(false),
  title: new Rox.Flag(false)
};

export const configurationFetchedHandler = fetcherResults => {
  console.log('The configuration status is: ' + fetcherResults.fetcherStatus)
  if (fetcherResults.hasChanges && fetcherResults.fetcherStatus === 'APPLIED_FROM_NETWORK') {
    window.location.reload(false)
  }
  else if (fetcherResults.fetcherStatus === 'ERROR_FETCH_FAILED') {
    console.log('Error occured! Details are: ' + fetcherResults.errorDetails)
  }
};

const options = {
  configurationFetchedHandler: configurationFetchedHandler
};

Rox.register('default', Flags);
Rox.setup(process.env.VUE_APP_ROLLOUT_KEY, options);
