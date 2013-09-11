//---------------------------------------------------------------------------
// Copyright 2013 PwC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//---------------------------------------------------------------------------

package gov.va.mumps.debug.ui;

import gov.va.mumps.debug.core.model.IMDebugTarget;
import gov.va.mumps.debug.core.model.MDebugPreference;

import java.util.EnumMap;

import org.eclipse.debug.core.ILaunch;
import org.eclipse.debug.core.ILaunchListener;
import org.eclipse.debug.core.model.IDebugTarget;

class OverallUIManager implements ILaunchListener {
	private EnumMap<MDebugPreference, ILaunchListener> listeners;
	
	private static ILaunchListener createListener(MDebugPreference debugPeference) {
		switch (debugPeference) {
		case GENERIC:
			return new GenericUIManager();
		case CACHE_TELNET:
			return new CacheTelnetUIManager();			
		default:
			return null;
		}		
	}
	
	private static ILaunchListener createAndAddListener(EnumMap<MDebugPreference, ILaunchListener> listeners, MDebugPreference debugPeference) {
		ILaunchListener result = createListener(debugPeference);
		if (result != null) {
			listeners.put(debugPeference, result);
		}
		return result;
	}
	
	private ILaunchListener getListener(ILaunch launch) {
		IDebugTarget target = launch.getDebugTarget();
		if (target instanceof IMDebugTarget) {
			IMDebugTarget mtarget = (IMDebugTarget) target;
			MDebugPreference preference = mtarget.getPreferenceImplemented();
			if (this.listeners == null) {
				this.listeners = new EnumMap<MDebugPreference, ILaunchListener>(MDebugPreference.class);
				return createAndAddListener(this.listeners, preference);
			}			
			ILaunchListener result = this.listeners.get(preference);
			if (result != null) {
				return result;
			}
			return createAndAddListener(this.listeners, preference);
		}
		return null;		
	}
			
	@Override
	public void launchAdded(ILaunch launch) {
		ILaunchListener listener = this.getListener(launch);
		if (listener != null) {
			listener.launchAdded(launch);
		}
	}

	@Override
	public void launchChanged(ILaunch launch) {
		ILaunchListener listener = this.getListener(launch);
		if (listener != null) {
			listener.launchChanged(launch);
		}
	}

	@Override
	public void launchRemoved(ILaunch launch) {
		ILaunchListener listener = this.getListener(launch);
		if (listener != null) {
			listener.launchRemoved(launch);
		}
	}
}
