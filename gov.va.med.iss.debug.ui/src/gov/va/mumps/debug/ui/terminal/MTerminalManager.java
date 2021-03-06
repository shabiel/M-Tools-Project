package gov.va.mumps.debug.ui.terminal;

import java.io.OutputStream;

import org.eclipse.swt.widgets.Display;
import org.eclipse.ui.IViewPart;
import org.eclipse.ui.IWorkbench;
import org.eclipse.ui.IWorkbenchPage;
import org.eclipse.ui.IWorkbenchWindow;
import org.eclipse.ui.PlatformUI;
import org.eclipse.ui.console.IConsoleManager;
import org.eclipse.ui.console.MessageConsole;

import us.pwc.vista.eclipse.core.helper.MessageConsoleHelper;

import gov.va.mumps.debug.core.IMInterpreterConsumer;
import gov.va.mumps.debug.core.model.IMTerminal;
import gov.va.mumps.debug.core.model.IMTerminalManager;
import gov.va.mumps.debug.ui.MDebugUIPlugin;

public class MTerminalManager implements IMTerminalManager {
	private IMTerminal showResult;
	
	public synchronized IMTerminal show(final String id, final IMInterpreterConsumer consumer) {
		Display.getDefault().syncExec(new Runnable() {						
			@Override
			public void run() {
				try {
					IWorkbench wb = PlatformUI.getWorkbench();
					IWorkbenchWindow window = wb.getActiveWorkbenchWindow();
					IWorkbenchPage wbp = window.getActivePage();
					IViewPart vp = wbp.showView(MDebugUIPlugin.TERMINAL_VIEW_ID, id, IWorkbenchPage.VIEW_ACTIVATE);
					MTerminalManager.this.showResult = (IMTerminal) vp;
					if (consumer != null) {
						IConsoleManager consoleManager = MessageConsoleHelper.getConsoleManager();
						MessageConsole messageConsole = MessageConsoleHelper.findConsole(consoleManager, "M Debug");
						consoleManager.showConsoleView(messageConsole);
						OutputStream messageStream = messageConsole.newMessageStream();
						((VistATerminalView) vp).connect(MTerminalManager.this, consumer, messageStream); 
					}
				} catch (Throwable t) {
					MTerminalManager.this.showResult = (IMTerminal) null;
				}
			}
		});
		return this.showResult;
	}
	
	@Override
	public IMTerminal create(String id, IMInterpreterConsumer consumer) {
		return this.show(id, consumer);
	}
		
	@Override
	public void giveFocus(String id) {
		this.show(id, null);
	}

	@Override
	public void disconnect(final String id) {
//		Display display = Display.getDefault();
//		if (! display.isDisposed()) {
//			display.syncExec(new Runnable() {						
//				@Override
//				public void run() {
//					IWorkbench wb = PlatformUI.getWorkbench();
//					IWorkbenchWindow window = wb.getActiveWorkbenchWindow();
//					IWorkbenchPage wbp = window.getActivePage();
//					IViewPart vp = wbp.findViewReference(MDebugUIPlugin.TERMINAL_VIEW_ID, id).getView(false);
//					((VistATerminalView) vp).disconnect(); 
//				}
//			});
//		}
	}

	@Override
	public void close(IMTerminal terminal) {
		if (terminal instanceof IViewPart) {
			final IViewPart vp = (IViewPart) terminal;
			Display.getDefault().syncExec(new Runnable() {						
				@Override
				public void run() {
					vp.getSite().getWorkbenchWindow().getActivePage().hideView(vp);				
				}
			});				
		}
	}
}
