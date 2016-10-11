package gov.va.mumps.debug.ui.terminal;

import java.io.OutputStream;

import gov.va.mumps.debug.core.IMInterpreterConsumer;
import gov.va.mumps.debug.core.model.IMTerminal;
import gov.va.mumps.debug.core.model.IMTerminalManager;

import org.eclipse.swt.widgets.Composite;
import org.eclipse.tm.internal.terminal.provisional.api.ITerminalConnector;
import org.eclipse.ui.part.ViewPart;

public class VistATerminalView extends ViewPart implements IMTerminal {
	@Override
	public void connect(IMTerminalManager terminalManager, IMInterpreterConsumer consumer, OutputStream messageStream) {
		ITerminalConnector connector = new VistATerminalConnector(consumer, terminalManager, messageStream, "utf-8"); 
		if (connector != null) {
			connector.connect(null);
		}
	}
	
	@Override
	/* NOTIMPLEMENTED at source */
	public void disconnect() {
//		.disconnectTerminal();			
	}
	
	@Override
	/* NOTIMPLEMENTED at source */
	public String getId() {
//		return this.getViewSite().getSecondaryId();
		return "";
	}
	
	@Override
	public void terminate() {
	}

	@Override
	public void createPartControl(Composite parent) {
		// TODO Auto-generated method stub
		return;
	}

	@Override
	public void setFocus() {
		// TODO Auto-generated method stub
		return;
		
	}
}